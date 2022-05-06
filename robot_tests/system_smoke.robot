*** Settings ***
Resource          ./system_smoke_kw.robot

*** Variables ***
${KUBELET_VERSION}     %{KUBELET_VERSION}
${NUM_BASE_NODES}           1

*** Test Cases ***
Pods in istio-system are ok
    [Documentation]  Test if all pods in istio-system initiated correctly and are running or succeeded
    [Tags]    istio    smoke
    Given kubernetes API responds
    When getting all pods names in "istio-system"
    Then all pods in "istio-system" are running or succeeded
