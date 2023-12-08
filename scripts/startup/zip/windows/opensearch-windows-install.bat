:: SPDX-License-Identifier: Apache-2.0
:: Copyright OpenSearch Contributors

@echo off

:: Set variables and cd into the location of the batch script
PUSHD "%~dp0"
SET "OPENSEARCH_HOME=%CD%"
SET "OPENSEARCH_PATH_CONF=%OPENSEARCH_HOME%\config"

:: Echo User Inputs
ECHO "OPENSEARCH_HOME: %OPENSEARCH_HOME%"
ECHO "OPENSEARCH_PATH_CONF: %OPENSEARCH_PATH_CONF%"

:: Security Plugin Setups
IF EXIST "%OPENSEARCH_HOME%\plugins\opensearch-security" (
    ECHO "Running Security Plugin Install Demo Configuration"
    ECHO "Please define an environment variable 'initialAdminPassword' with a password string."
    ECHO "Or create a file 'initialAdminPassword.txt' with a single line that contains the password string and place it under %OPENSEARCH_PATH_CONF% folder."
    ECHO "If none of these are provided, a password will be generated and printed out to the logs."
    CALL "%OPENSEARCH_HOME%\plugins\opensearch-security\tools\install_demo_configuration.bat" -y -i -s || exit /b 1
)

:: k-NN Plugin Setups
ECHO "Set KNN Dylib Path for Windows systems"
SET "PATH=%PATH%;%OPENSEARCH_HOME%/plugins/opensearch-knn/lib"

:: Start OpenSearch
ECHO Start OpenSearch
IF "%~1" == "" (
    CALL "%OPENSEARCH_HOME%\bin\opensearch.bat"
    ) ELSE (
    CALL "%OPENSEARCH_HOME%\bin\opensearch.bat" "%*"
    )

