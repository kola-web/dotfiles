#SingleInstance
#Requires AutoHotkey >=v2.0

*LControl::
{
	thisKey := "LControl"

	Send "{LControl down}"
	KeyWait(thisKey)
	Send "{LControl up}"

	pressedNoNewKey := A_PriorKey = thisKey

	if (pressedNoNewKey)
	{
		Send "{Escape}"
	}
}
