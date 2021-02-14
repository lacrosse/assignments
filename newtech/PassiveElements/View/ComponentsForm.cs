using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Xml.Serialization;
using System.IO;
using Model;

namespace View
{
    public partial class ComponentsForm : Form
    {
        public List<PassiveComponent> ComponentList = new List<PassiveComponent>();
        public XmlSerializer ComponentListSerializer = new XmlSerializer(typeof(List<PassiveComponent>));

        public ComponentsForm()
        {
            InitializeComponent();

            #if DEBUG
            CreateRandomButton.Visible = true;
            #endif
        }

        private void InitList()
        {
            PassiveComponent component = new Model.Resistor(93);
            ComponentList.Add(component);
        }

        private void ConfigureGrid()
        {
            Grid.DataSource = null;
            Grid.DataSource = ComponentList;
            Grid.Columns.Remove("ShortName");
            Grid.Columns.Remove("VarName");
            Grid.Columns["ComponentVariable"].HeaderText = "Variable";
        }

        private void ComponentsForm_Load(object sender, EventArgs e)
        {
            InitList();
            ConfigureGrid();
        }

        private void Grid_SelectionChanged(object sender, EventArgs e)
        {
            if (Grid.SelectedRows.Count == 0)
            {
                RemoveObjectButton.Enabled = false;
            }
            else
            {
                RemoveObjectButton.Enabled = true;
            }
        }

        private void AddComponent(string componentType, double variable)
        {
            Model.PassiveComponent component;
            switch (componentType)
            {
                case "Resistor":
                    component = new Resistor(variable);
                    break;
                case "Capacitor":
                    component = new Capacitor(variable);
                    break;
                case "Inductor":
                    component = new Inductor(variable);
                    break;
                default:
                    throw new ArgumentException($"Wrong component type selected: {componentType}");
            }
            ComponentList.Add(component);
            ConfigureGrid();
        }

        private void AddObjectButton_Click(object sender, EventArgs e)
        {
            var form = new NewComponentForm();
            form.ShowDialog();
            if (form.Create)
            {
                (string componentType, double variable) = form.GetResult();
                AddComponent(componentType, variable);
            }
        }

        private void RemoveObjectButton_Click(object sender, EventArgs e)
        {
            if (Grid.SelectedRows.Count > 0)
            {
                int i = Grid.SelectedRows[0].Index;
                ComponentList.RemoveAt(i);
                ConfigureGrid();
            }
        }

        private void CreateRandomButton_Click(object sender, EventArgs e)
        {
            string[] componentTypes = { "Resistor", "Capacitor", "Inductor" };
            var rnd = new Random();
            AddComponent(componentTypes[rnd.Next(3)], rnd.Next(1, 50));
        }

        private void SaveFileButton_Click(object sender, EventArgs e)
        {
            var dialog = new SaveFileDialog()
            {
                Filter = "PassiveComponents database|*.pcdb",
                Title = "Save database file"
            };

            dialog.ShowDialog();
            if (dialog.FileName != "")
            {
                using (var fs = (FileStream)dialog.OpenFile())
                {
                    ComponentListSerializer.Serialize(fs, ComponentList);
                    fs.Close();
                }
            }
        }

        private void OpenFileButton_Click(object sender, EventArgs e)
        {
            var dialog = new OpenFileDialog()
            {
                Filter = "PassiveComponents database|*.pcdb",
                Title = "Open database file"
            };

            dialog.ShowDialog();
            if (dialog.FileName != "")
            {
                using (var fs = (FileStream)dialog.OpenFile())
                {
                    ComponentList = (List<PassiveComponent>)ComponentListSerializer.Deserialize(fs);
                    ConfigureGrid();
                    fs.Close();
                }
            }
        }

        private void SearchButton_Click(object sender, EventArgs e)
        {
            var searchForm = new SearchForm(ComponentList);
            searchForm.ShowDialog();
        }
    }
}
