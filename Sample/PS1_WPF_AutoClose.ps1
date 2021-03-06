[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       				| out-null

function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

$XamlMainWindow=LoadXml("PS1_WPF_AutoClose.xaml")

$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)

$Logo_CM = $Form.findname("Logo_CM") 
$Label_Close = $Form.findname("Label_Close") 
$OK_Text = $Form.findname("OK_Text") 

$Script:Timer = New-Object System.Windows.Forms.Timer
$Timer.Interval = 1000

Function Timer_Tick()
{
	$Label_Close.Content = "The window will close in $Script:CountDown seconds"
	 --$Script:CountDown
	 If ($Script:CountDown -lt 0)
	 {
		$Timer.Stop(); 
		$Form.Close(); 
		$Timer.Dispose();
		$Script:CountDown = 5		
	 }
	 
	 
}

$Script:CountDown = 6
$Timer.Add_Tick({ Timer_Tick})
$Timer.Start()	

$Form.ShowDialog() | Out-Null