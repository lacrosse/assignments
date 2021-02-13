using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public abstract class PassiveComponent
    {
        public PassiveComponent(double var)
        {
            ComponentVariable = var;
        }

        public abstract string Name { get; }
        public abstract string ShortName { get; }
        public abstract string VarName { get; }

        private double _component_variable;
        public double ComponentVariable
        {
            get => _component_variable;
            set
            {
                if (_component_variable < 0)
                    throw new ArgumentException($"You can't have a {Name} with negative {VarName}.");
                else
                    _component_variable = value;
            }
        }

        public override string ToString() => $"[#{ShortName} = {ComponentVariable}]";
        public abstract double Impedance(double arg);
    }

    public class Resistor : PassiveComponent
    {
        public Resistor(double resistance) : base(resistance) { }

        public override string Name { get => "resistor"; }
        public override string ShortName { get => "R"; }
        public override string VarName { get => "resistance";  }

        public override double Impedance(double _arg) => ComponentVariable;
    }

    public class Capacitor : PassiveComponent
    {
        public Capacitor(double capacitance) : base(capacitance) { }

        public override string Name { get => "capacitor"; }
        public override string ShortName { get => "C"; }
        public override string VarName { get => "capacitance"; }

        public override double Impedance(double arg) => 1 / (arg * ComponentVariable);
    }

    public class Inductor : PassiveComponent
    {
        public Inductor(double inductance) : base(inductance) { }

        public override string Name { get => "inductor"; }
        public override string ShortName { get => "L"; }
        public override string VarName { get => "inductance"; }

        public override double Impedance(double arg) => arg * ComponentVariable;
    }
}
