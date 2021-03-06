# Changelog

Here you can see an overview of changes between each release.

## Version 4.2.0_02

Released on July 29th, 2020.

* Fixed missing `bash` executable for Jython script. Reference: https://github.com/GluuFederation/docker-oxauth/issues/21.

## Version 4.2.0_01

Released on July 18th, 2020.

* Added support for Gluu Server v4.2.
* Upraded to Java 11.
* Upgraded to Python3.

## Version 4.1.2_01

Released on July 11th, 2020.

* Upgraded `oxauth-server`.
* Add support to use any client authentication for revoke token endpoint

## Version 4.1.1_09

Released on June 5th, 2020.

* Upgraded `oxauth-server`.
* Changed logging level for RClone wrapper script.

## Version 4.1.1_08

Released on May 21st, 2020.

* Fixed Curl package installation.

## Version 4.1.1_07

Released on May 20th, 2020.

* Added Curl package.
* Added support for Jackrabbit (Java Content Repository/JCR).
* Added RClone to interact with Jackrabbit via webdav protocol.

## Version 4.1.1_06

Released on April 29th, 2020.

* Added Jython site-packages.

## Version 4.1.1_05

Released on April 20th, 2020.

* Upgraded `oxauth-server`.

## Version 4.1.1_04

Released on April 17th, 2020.

* Upgraded `oxauth-server`.

* Upgrade Jython package.

* Conform to changes in key rotation logic . Fixes [Key Rotation issue #7](https://github.com/GluuFederation/docker-key-rotation/issues/7) in commit https://github.com/GluuFederation/docker-oxauth/commit/16cd18d34304d0ce91f0e4598fbd6a91d8cf2d0f

  1. oxAuth starts off using old/expired JWKS + JKS

  1. Key-rotation re-generates new JWKS + JKS

  1. Key-rotation creates a backup of old JKS and JWKS in oxAuth at /etc/certs/oxauth-keys.jks and /etc/certs/oxauth-keys.json. Note: At this point oxAuth is still using cached (old/expired) JWKS + JKS.

  1. Key-rotation pushes new JKS .Note: At this point oxAuth is still using cached (old/expired) JWKS + JKS.

  1. Key-rotation saves the JWKS in persistence:

    - if the process fails key rotation restores the JSK from backup in oxAuth

    - if the process succeeds, oxAuth reloads itself hence loading new JWKS + JKS pair


## Version 4.1.1_03

Released on April 2nd, 2020.

* Upgraded `oxauth-server`.
* Added `casawatcher` script.

## Version 4.1.1_02

Released on March 25th, 2020.

* Upgraded `oxauth-server` v4.1.1 build at 2020-03-25 to address issue with key regeneration interval (https://github.com/GluuFederation/oxAuth/issues/1299).

## Version 4.1.1_01

Released on March 24th, 2020.

* Conformed to Gluu Server v4.1.1.

## Version 4.1.0_01

Released on March 5th, 2020.

* Conformed to Gluu Server v4.1.

## Version 4.0.1_08

Released on March 5th, 2020.

* Upgraded `oxauth-server` v4.0.sp1.
* Added ENV for customizing Couchbase connection and scan consistency.

## Version 4.0.1_07

Released on January 22nd, 2020.

* Upgraded `oxauth-server` v4.0.Final.patch1 build at 2020-01-20.

## Version 4.0.1_06

Released on December 25th, 2019.

* Pulled SCIM RP and RS client keystores and JWKS files upon container deployment. Reference: https://github.com/GluuFederation/enterprise-edition/issues/22.

## Version 4.0.1_05

Released on December 1st, 2019.

* Upgraded `oxauth-server` v4.0.1.Final build at 2019-11-30.

## Version 4.0.1_04

Released on November 19th, 2019.

* Upgraded to oxAuth v4.0.1.Final build at 2019-11-18.

## Version 4.0.1_03

Released on November 15th, 2019.

* Upgraded to oxAuth v4.0.1.Final build at 2019-11-14.

## Version 4.0.1_02

Released on November 14th, 2019.

* Upgraded `pygluu-containerlib` to show connection issue with Couchbase explicitly.
* Upgraded to oxAuth v4.0.1.Final build at 2019-11-13.

## Version 4.0.1_01

Released on November 1st, 2019.

* Upgraded to Gluu Server 4.0.1.

## Version 4.0.0_01

Released on October 22nd, 2019.

* Upgraded to Gluu Server 4.0.
* Fixed bugs where `twilio.jar` is deleted when there is volume mounted to `/opt/gluu/jetty/oxauth/custom/libs` directory.

## Version 3.1.6_02

Released on May 10th, 2019.

* Alpine upgraded to v3.9. Ref: https://github.com/GluuFederation/gluu-docker/issues/71.

## Version 3.1.6_01

Released on April 29th, 2019.

* Upgraded to Gluu Server 3.1.6.

## Version 3.1.5_04

Released on May 10th, 2019.

* Alpine upgraded to v3.9. Ref: https://github.com/GluuFederation/gluu-docker/issues/71.

## Version 3.1.5_03

* Added `GLUU_SYNC_JKS_INTERVAL` env var.

Released on April 23rd, 2019.

* Added license info on container startup.

## Version 3.1.5_02

Released on April 9th, 2019.

* Added license info on container startup.
* Disabled `sendServerVersion` config of Jetty server.

## Version 3.1.5_01

Released on March 23rd, 2019.

* Upgraded to Gluu Server 3.1.5.

## Version 3.1.4_04

Released on April 4th, 2019.

* Added license info during container run.

## Version 3.1.4_03

Released on February 16th, 2019.

* Added missing `idp-signing.crt` and `passport-rp.jks` files.

## Version 3.1.4_02

Released on January 16th, 2019.

* Added `http-forwarded` module to Jetty.

## Version 3.1.4_01

Released on November 12th, 2018.

* Upgraded to Gluu Server 3.1.4.

## Version 3.1.3_05

Released on September 18th, 2018.

* Changed base image to use Alpine 3.8.1.

## Version 3.1.3_04

Released on September 12th, 2018.

* Added feature to connect to secure Consul (HTTPS).

## Version 3.1.3_03

Released on August 31st, 2018.

* Added Tini to handle signal forwarding and reaping zombie processes.

## Version 3.1.3_02

Released on July 20th, 2018.

* Added wrapper to manage config via Consul KV or Kubernetes configmap.

## Version 3.1.3_01

Released on June 6th, 2018.

* Upgraded to Gluu Server 3.1.3.

## Version 3.1.2_01

Released on June 6th, 2018.

* Upgraded to Gluu Server 3.1.2.

## Version 3.1.1_rev1.0.0-beta3

Released on March 14th, 2018.

* Added feature to enable/disable remote debugging of JVM.

## Version 3.1.1_rev1.0.0-beta2

Released on October 11th, 2017.

* Use latest oxauth-server build.

## Version 3.1.1_rev1.0.0-beta1

Released on October 6th, 2017.

* Migrated to Gluu Server 3.1.1.

## Version 3.0.1_rev1.0.0-beta3

Released on August 16th, 2017.

* Fixed base64 encryption when synchronizing keys.

## Version 3.0.1_rev1.0.0-beta2

Released on July 25th, 2017.

* Fixed extraction process of custom oxAuth files where empty directories couldn't be copied to pre-defined custom directories.

## Version 3.0.1_rev1.0.0-beta1

Released on July 7th, 2017.

* Added working oxAuth v3.0.1.
* Added feature to synchronize `oxauth-keys.jks`.
