BeforeAll {
    $scriptPath = Join-Path $PSScriptRoot '..\scripts\Test-RoomInventory.ps1'
}

Describe 'Test-RoomInventory' {
    It 'has valid PowerShell syntax' {
        $tokens = $null; $errors = $null
        [System.Management.Automation.Language.Parser]::ParseFile($scriptPath,[ref]$tokens,[ref]$errors) | Out-Null
        $errors.Count | Should -Be 0
    }

    It 'validates a safe synthetic inventory without external connections' {
        $inputPath = Join-Path $TestDrive 'rooms.csv'
        $outputPath = Join-Path $TestDrive 'result.json'
        @'
RoomId,Location,Capacity,Platform,DisplayCount,Camera,AudioDevice,Connection,SupportTier
DEMO-RM-101,Berlin-DEMO-F1,6,Teams,1,DEMO-CAM-01,DEMO-AUDIO-01,HDMI-USB,Standard
'@ | Set-Content $inputPath
        & $scriptPath -InventoryPath $inputPath -OutputPath $outputPath | Out-Null
        $result = Get-Content -Raw $outputPath | ConvertFrom-Json
        $result.Environment | Should -Be 'Synthetic practice framework'
        $result.ConnectedToDevicesOrServices | Should -BeFalse
        $result.PassedCount | Should -Be 1
    }

    It 'flags a non-synthetic room identifier' {
        $inputPath = Join-Path $TestDrive 'invalid.csv'
        @'
RoomId,Location,Capacity,Platform,DisplayCount,Camera,AudioDevice,Connection,SupportTier
ROOM-01,Unknown,6,Teams,1,Camera,Audio,HDMI,Standard
'@ | Set-Content $inputPath
        $result = & $scriptPath -InventoryPath $inputPath -OutputPath (Join-Path $TestDrive 'invalid.json')
        $result.PassedCount | Should -Be 0
        $result.Findings[0].Messages | Should -Contain 'RoomId must use the synthetic DEMO format'
    }
}
