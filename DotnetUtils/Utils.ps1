function PressAnyKeyToContinue {
    <#
        .SYNOPSIS
        Show "Press any key to continue..." prompt.
        
        .EXAMPLE
        PS> PressAnyKeyToContinue
    #>

    Write-Host -NoNewLine 'Press any key to continue...';
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}
