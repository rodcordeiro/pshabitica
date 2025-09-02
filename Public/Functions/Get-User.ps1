function Get-User {
    param()
    begin {
        $uri = "/user"
    }
    process {
        $response = invoke-api -Uri $uri -method GET 
        Write-Output $response.data
    }
}