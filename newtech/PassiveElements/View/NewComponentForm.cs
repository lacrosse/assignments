using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace View
{
    public partial class NewComponentForm : Form
    {
        public bool Create = false;

        public NewComponentForm()
        {
            InitializeComponent();
        }

        private void CreateComponentButton_Click(object sender, EventArgs e)
        {
            if (ComponentTypeBox.SelectedItem is null)
            {
                MessageBox.Show("Select component type", "Error!");
            } else 
            {
                Create = true;
                Close();
            }
        }

        private void CancelCreationButton_Click(object sender, EventArgs e)
        {
            Close();
        }

        public (string, double) GetResult()
        {
            var item = ComponentTypeBox.SelectedItem;
            string type;
            if (item is null)
            {
                type = "";
            }
            else
            {
                type = item.ToString();
            }
            return (type, (double)VariableUpDown.Value);
        }
    }
}
