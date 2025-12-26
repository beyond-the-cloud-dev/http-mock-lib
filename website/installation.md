# Installation

## Install via Unlocked Package

<!--
 sf package version create --package "HTTP Mock Lib" --target-dev-hub beyondthecloud-prod --installation-key-bypass --wait 30 --code-coverage

 sf package version promote --package "HTTP Mock Lib@1.2.0-1"  --target-dev-hub beyondthecloud-prod
-->

Install the HTTP Mock Lib unlocked package with `btcdev` namespace to your Salesforce environment:

`/packaging/installPackage.apexp?p0=04tP6000002EJBJIA4`

[Install on Sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04tP6000002EJBJIA4)

[Install on Production](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tP6000002EJBJIA4)

<!-- ## Install via Unmanaged Package

Install the HTTP Mock Lib unmanaged package without namespace to your Salesforce environment:

`/packaging/installPackage.apexp?p0=04tP6000000XXXXXXT`

[Install on Sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04tP6000000XXXXXXT)

[Install on Production](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tP6000000XXXXXXT) -->

## Deploy via Button

Click the button below to deploy HTTP Mock Lib to your environment.

<a href="https://githubsfdeploy.herokuapp.com?owner=beyond-the-cloud-dev&repo=http-mock-lib&ref=main">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

## Copy and Deploy

**Apex**

- [`HttpMock.cls`](https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/force-app/main/default/classes/HttpMock.cls)
- [`HttpMockTest.cls`](https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/force-app/main/default/classes/HttpMockTest.cls)
