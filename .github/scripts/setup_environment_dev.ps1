$owner = "ricardotolentino"
$repo = "function-cicd"
$env = "dev"

$secretName = "AZURE_CREDENTIALS"
$secretFile = "credentials/azure_credentials_dev.json"

$varFunctionName = "FUNCTION_NAME"
$varFunctionValue = "func-function-cicd-dev-cus"

$repoFull = "$owner/$repo"

gh api `
    -X PUT `
    -H "Accept: application/vnd.github+json" `
    "/repos/$owner/$repo/environments/$env"
Get-Content "$secretFile" | gh secret set "$secretName" -R "$repoFull" -e "$env"
gh variable set "$varFunctionName" -R "$repoFull" -e "$env" -b "$varFunctionValue"