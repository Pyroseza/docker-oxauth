#!/bin/sh
set -e

download_custom_tar() {
    if [ ! -z ${GLUU_CUSTOM_OXAUTH_URL} ]; then
        mkdir -p /tmp/oxauth
        wget -q ${GLUU_CUSTOM_OXAUTH_URL} -O /tmp/oxauth/custom-oxauth.tar.gz
        cd /tmp/oxauth
        tar xf custom-oxauth.tar.gz

        if [ -d /tmp/oxauth/pages ]; then
            cp -R /tmp/oxauth/pages/ /opt/gluu/jetty/oxauth/custom/
        fi

        if [ -d /tmp/oxauth/static ]; then
            cp -R /tmp/oxauth/static/ /opt/gluu/jetty/oxauth/custom/
        fi

        if [ -d /tmp/oxauth/i18n ]; then
            cp -R /tmp/oxauth/i18n/ /opt/gluu/jetty/oxauth/custom/
        fi

        if [ -d /tmp/oxauth/libs ]; then
            cp -R /tmp/oxauth/libs/ /opt/gluu/jetty/oxauth/custom/
        fi

        if [ -d /tmp/oxauth/lib/ext ]; then
            cp -R /tmp/oxauth/lib/ext/ /opt/gluu/jetty/oxauth/lib/
        fi
    fi
}

import_ssl_cert() {
    if [ -f /etc/certs/gluu_https.crt ]; then
        openssl x509 -outform der -in /etc/certs/gluu_https.crt -out /etc/certs/gluu_https.der
        keytool -importcert -trustcacerts \
            -alias gluu_https \
            -file /etc/certs/gluu_https.der \
            -keystore /usr/lib/jvm/default-jvm/jre/lib/security/cacerts \
            -storepass changeit \
            -noprompt
    fi
}

get_java_opts() {
    local java_opts="
        -server \
        -XX:+UnlockExperimentalVMOptions \
        -XX:+UseCGroupMemoryLimitForHeap \
        -XX:MaxRAMFraction=$GLUU_MAX_RAM_FRACTION \
        -XX:+DisableExplicitGC \
        -Dgluu.base=/etc/gluu \
        -Dserver.base=/opt/gluu/jetty/oxauth \
        -Dlog.base=/opt/gluu/jetty/oxauth \
        -Dpython.home=/opt/jython

    "

    if [ -n "${GLUU_DEBUG_PORT}" ]; then
        java_opts="
            ${java_opts}
            -agentlib:jdwp=transport=dt_socket,address=${GLUU_DEBUG_PORT},server=y,suspend=n
        "
    fi

    echo "${java_opts}"
}

if [ ! -f /deploy/touched ]; then
    download_custom_tar
    if [ -f /etc/redhat-release ]; then
        source scl_source enable python27 && python /opt/scripts/entrypoint.py
    else
        python /opt/scripts/entrypoint.py
    fi
    import_ssl_cert
    touch /deploy/touched
fi

if [ -f /etc/redhat-release ]; then
    source scl_source enable python27 && python /opt/scripts/jks_sync.py &
else
    python /opt/scripts/jks_sync.py &
fi

cd /opt/gluu/jetty/oxauth
exec java \
    $(get_java_opts) \
    -jar /opt/jetty/start.jar
