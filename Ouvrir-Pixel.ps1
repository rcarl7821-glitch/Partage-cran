$ErrorActionPreference = 'Stop'
$Host.UI.RawUI.WindowTitle = 'Pixel Local - connexion'
Write-Host 'Pixel Local : recherche du telephone sur les passerelles locales...' -ForegroundColor Cyan
Write-Host 'Le PC doit etre connecte au point d acces du Pixel, et le partage doit etre actif.'
try {
    $configs = @(Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway })
    $wifi = @($configs | Where-Object { $_.InterfaceAlias -match 'Wi-Fi|WLAN|Wireless' -or $_.InterfaceDescription -match 'Wi-Fi|WLAN|Wireless|802.11' })
    $ordered = @($wifi) + @($configs | Where-Object { $_ -notin $wifi })
    $gateways = @($ordered | ForEach-Object { $_.IPv4DefaultGateway.NextHop } | Select-Object -Unique)
    foreach ($gateway in $gateways) {
        if ($gateway -notmatch '^\d{1,3}(\.\d{1,3}){3}$') { continue }
        $url = 'http://' + $gateway + ':8080/'
        Write-Host "Test de $url"
        try {
            $r = Invoke-WebRequest -UseBasicParsing -Uri ($url + 'health') -TimeoutSec 3
            if ($r.Content.Trim() -eq 'PIXEL_LOCAL_2') {
                Start-Process $url
                Write-Host 'Telephone trouve. Ouverture du navigateur.' -ForegroundColor Green
                exit 0
            }
        } catch { }
    }
    Write-Host ''
    Write-Host 'Pixel Local 2.0 ne repond pas sur les passerelles disponibles.' -ForegroundColor Yellow
    Write-Host 'Verifier le reseau Wi-Fi du PC puis lancer le partage sur le Pixel.'
    Write-Host 'Le navigateur peut aussi ouvrir directement l adresse affichee dans l application.'
    Read-Host 'Entree pour fermer'
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
    Read-Host 'Entree pour fermer'
}
