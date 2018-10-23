Option Explicit

Function runcmd(strCmd)
  'WScript.Echo strCmd
  dim ret
  dim objWshShell
  Set objWshShell = WScript.CreateObject("WScript.Shell")
  ret = objWshShell.Run(strCmd, 1, True)
  set objWshShell = Nothing
  runcmd = ret
End Function

Function execcmd(strCmd)
  dim ret
  dim objWshShell, oExec
  Set objWshShell = WScript.CreateObject("WScript.Shell")
  set oExec = objWshShell.Exec(strCmd)
  Do While oExec.Status = 0
     WScript.Sleep 100
  Loop
  execcmd = oExec.StdOut.ReadAll
  set oExec = Nothing
  set objWshShell = Nothing
End Function
