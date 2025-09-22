*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://192.168.1.101:5000

*** Test Cases ***
Plus With Valid Numbers
    [Documentation]    ทดสอบ /plus/<a>/<b> ด้วยตัวเลขถูกต้อง
    ${response}=      GET    ${BASE_URL}/plus/3/5
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=          To Json    ${response.content}
    Should Be Equal As Integers    ${json['result']}    8

Plus With Invalid Numbers
    [Documentation]    ทดสอบ /plus/<a>/<b> ด้วย input ไม่ใช่ตัวเลข
    ${response}=      GET    ${BASE_URL}/plus/foo/bar
    Should Be Equal As Integers    ${response.status_code}    400
    ${json}=          To Json    ${response.content}
    Should Contain    ${json['error']}    Invalid numbers
