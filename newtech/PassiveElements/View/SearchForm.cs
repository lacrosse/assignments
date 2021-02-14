using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Model;

namespace View
{
    public partial class SearchForm : Form
    {
        private List<PassiveComponent> FullList { get; }
        public SearchForm(List<PassiveComponent> componentList)
        {
            InitializeComponent();
            FullList = componentList;
        }

        List<PassiveComponent> FilterList(List<PassiveComponent> list)
        {
            var type_item = ComponentTypeComboBox.SelectedItem;
            Func<PassiveComponent, bool> byType;
            if (type_item is null || type_item.ToString() == "")
            {
                byType = c => true;
            }
            else
            {
                byType = c => c.Name == type_item.ToString().ToLower();
            }
            var upper = VariableTrackBar.Value;
            return list.Where(c => c.ComponentVariable <= upper && byType(c)).ToList();
        }

        private void SearchForm_Load(object sender, EventArgs e)
        {
            ConfigureGrid();
        }

        private void ConfigureGrid()
        {
            Grid.DataSource = null;
            Grid.DataSource = FilterList(FullList);
            Grid.Columns.Remove("ShortName");
            Grid.Columns.Remove("VarName");
            Grid.Columns["ComponentVariable"].HeaderText = "Variable";
        }

        private void SearchControlChanged(object sender, EventArgs e)
        {
            ConfigureGrid();
        }
    }
}
