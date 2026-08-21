using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;

internal static class Program
{
    private static int Main(string[] args)
    {
        string directory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
        string script = Path.Combine(directory, "MyWhisper.cmd");
        Process.Start(new ProcessStartInfo
        {
            FileName = script,
            Arguments = QuoteArguments(args),
            WorkingDirectory = directory,
            UseShellExecute = true,
        });
        return 0;
    }

    private static string QuoteArguments(string[] args)
    {
        if (args == null || args.Length == 0)
        {
            return "";
        }

        string[] quoted = new string[args.Length];
        for (int index = 0; index < args.Length; index++)
        {
            quoted[index] = "\"" + args[index].Replace("\"", "\\\"") + "\"";
        }

        return string.Join(" ", quoted);
    }
}
