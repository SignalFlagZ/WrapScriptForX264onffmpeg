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

Function copytoclipboard(str)
  dim cmd
  'str = Replace(str, """", "\""", vbTextCompare)
  str = Replace(str, "'", "\'", vbTextCompare)
  str = Replace(str, "\", "\\", vbTextCompare)
  cmd = "mshta ""javascript:Code(close(clipboardData.setData('text','" & str & "')));"""
  runcmd(cmd)
End Function

Function HasValue(val)
  if IsNull(val) then HasValue = False :Exit Function
  'if IsEmpty(val) then HasValue = False : Exit Function
  if IsObject(val) then HasValue = False : Exit Function
  HasValue = True
End Function
  