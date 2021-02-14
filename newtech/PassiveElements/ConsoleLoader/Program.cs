using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleLoader
{
    class Program
    {
        static double ReadDouble()
        {
            string str;
            
            while (true)
            {
                str = Console.ReadLine();
                try
                {
                    return Double.Parse(str);
                }
                catch (FormatException)
                {
                    Console.WriteLine($"I can't parse {str}, Dave. Try again.");
                }
            }
        }

        static void Main()
        {
            Model.PassiveComponent component;

            Console.WriteLine("Good morning, Dave.");
            Console.WriteLine("Today is our component testing day.");
            Console.WriteLine("We'll be creating several components and viewing their impedance (aka complex resistance).");
            Console.WriteLine("Impedance is a function Z(jω), so I'll be asking you for the arguments as well.");

            Console.WriteLine("Give me a value, I'll assume it's ohms and create a resistor for you:");

            component = new Model.Resistor(ReadDouble());

            Console.WriteLine($"Here's your component: {component}.");
            Console.WriteLine($"Resistor's impedance is constant and equals {component.Impedance(0)} ohm for any jω. It's so great that we have Unicode.");
            Console.WriteLine("Moving on. Give me farads and I'll create a capacitor:");

            component = new Model.Capacitor(ReadDouble());

            Console.WriteLine($"Here's your component: {component}. Now give me a jω argument for the impedance function:");

            double var = ReadDouble();

            Console.WriteLine($"Capacitor's impedance equals {component.Impedance(var)} ohm at {var}.");
            Console.WriteLine("One more. Give me henries and I'll create an inductor:");

            component = new Model.Inductor(ReadDouble());

            Console.WriteLine($"Here's your component: {component}. Now give me a jω argument for the impedance function:");

            var = ReadDouble();

            Console.WriteLine($"Inductor's impedance equals {component.Impedance(var)} ohm at {var}.");
            Console.WriteLine("Thank you, Dave. See you later. Press any key to put me to sleep.");

            Console.Read();
        }
    }
}
