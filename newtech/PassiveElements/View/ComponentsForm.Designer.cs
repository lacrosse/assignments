
namespace View
{
    partial class ComponentsForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.Box = new System.Windows.Forms.GroupBox();
            this.Grid = new System.Windows.Forms.DataGridView();
            this.RemoveObjectButton = new System.Windows.Forms.Button();
            this.AddObjectButton = new System.Windows.Forms.Button();
            this.BindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.CreateRandomButton = new System.Windows.Forms.Button();
            this.SaveFileButton = new System.Windows.Forms.Button();
            this.OpenFileButton = new System.Windows.Forms.Button();
            this.SearchButton = new System.Windows.Forms.Button();
            this.Box.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.Grid)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.BindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // Box
            // 
            this.Box.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.Box.Controls.Add(this.Grid);
            this.Box.Location = new System.Drawing.Point(13, 13);
            this.Box.Name = "Box";
            this.Box.Size = new System.Drawing.Size(775, 396);
            this.Box.TabIndex = 0;
            this.Box.TabStop = false;
            this.Box.Text = "Passive components database";
            // 
            // Grid
            // 
            this.Grid.AllowUserToAddRows = false;
            this.Grid.AllowUserToDeleteRows = false;
            this.Grid.AllowUserToResizeRows = false;
            this.Grid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.Grid.Dock = System.Windows.Forms.DockStyle.Fill;
            this.Grid.Location = new System.Drawing.Point(3, 16);
            this.Grid.Name = "Grid";
            this.Grid.Size = new System.Drawing.Size(769, 377);
            this.Grid.TabIndex = 0;
            this.Grid.SelectionChanged += new System.EventHandler(this.Grid_SelectionChanged);
            // 
            // RemoveObjectButton
            // 
            this.RemoveObjectButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.RemoveObjectButton.Location = new System.Drawing.Point(668, 415);
            this.RemoveObjectButton.Name = "RemoveObjectButton";
            this.RemoveObjectButton.Size = new System.Drawing.Size(120, 23);
            this.RemoveObjectButton.TabIndex = 1;
            this.RemoveObjectButton.Text = "Remove component";
            this.RemoveObjectButton.UseVisualStyleBackColor = true;
            this.RemoveObjectButton.Click += new System.EventHandler(this.RemoveObjectButton_Click);
            // 
            // AddObjectButton
            // 
            this.AddObjectButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.AddObjectButton.Location = new System.Drawing.Point(562, 415);
            this.AddObjectButton.Name = "AddObjectButton";
            this.AddObjectButton.Size = new System.Drawing.Size(100, 23);
            this.AddObjectButton.TabIndex = 2;
            this.AddObjectButton.Text = "Add component";
            this.AddObjectButton.UseVisualStyleBackColor = true;
            this.AddObjectButton.Click += new System.EventHandler(this.AddObjectButton_Click);
            // 
            // CreateRandomButton
            // 
            this.CreateRandomButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.CreateRandomButton.Location = new System.Drawing.Point(363, 415);
            this.CreateRandomButton.Name = "CreateRandomButton";
            this.CreateRandomButton.Size = new System.Drawing.Size(104, 23);
            this.CreateRandomButton.TabIndex = 3;
            this.CreateRandomButton.Text = "Create random";
            this.CreateRandomButton.UseVisualStyleBackColor = true;
            this.CreateRandomButton.Visible = false;
            this.CreateRandomButton.Click += new System.EventHandler(this.CreateRandomButton_Click);
            // 
            // SaveFileButton
            // 
            this.SaveFileButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.SaveFileButton.Location = new System.Drawing.Point(93, 415);
            this.SaveFileButton.Name = "SaveFileButton";
            this.SaveFileButton.Size = new System.Drawing.Size(75, 23);
            this.SaveFileButton.TabIndex = 4;
            this.SaveFileButton.Text = "Save to file";
            this.SaveFileButton.UseVisualStyleBackColor = true;
            this.SaveFileButton.Click += new System.EventHandler(this.SaveFileButton_Click);
            // 
            // OpenFileButton
            // 
            this.OpenFileButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.OpenFileButton.Location = new System.Drawing.Point(12, 415);
            this.OpenFileButton.Name = "OpenFileButton";
            this.OpenFileButton.Size = new System.Drawing.Size(75, 23);
            this.OpenFileButton.TabIndex = 5;
            this.OpenFileButton.Text = "Open file";
            this.OpenFileButton.UseVisualStyleBackColor = true;
            this.OpenFileButton.Click += new System.EventHandler(this.OpenFileButton_Click);
            // 
            // SearchButton
            // 
            this.SearchButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.SearchButton.Location = new System.Drawing.Point(174, 415);
            this.SearchButton.Name = "SearchButton";
            this.SearchButton.Size = new System.Drawing.Size(75, 23);
            this.SearchButton.TabIndex = 6;
            this.SearchButton.Text = "Search";
            this.SearchButton.UseVisualStyleBackColor = true;
            this.SearchButton.Click += new System.EventHandler(this.SearchButton_Click);
            // 
            // ComponentsForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.SearchButton);
            this.Controls.Add(this.OpenFileButton);
            this.Controls.Add(this.SaveFileButton);
            this.Controls.Add(this.CreateRandomButton);
            this.Controls.Add(this.AddObjectButton);
            this.Controls.Add(this.RemoveObjectButton);
            this.Controls.Add(this.Box);
            this.MinimumSize = new System.Drawing.Size(400, 38);
            this.Name = "ComponentsForm";
            this.Text = "Components";
            this.Load += new System.EventHandler(this.ComponentsForm_Load);
            this.Box.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.Grid)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.BindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox Box;
        private System.Windows.Forms.DataGridView Grid;
        private System.Windows.Forms.Button RemoveObjectButton;
        private System.Windows.Forms.Button AddObjectButton;
        private System.Windows.Forms.BindingSource BindingSource;
        private System.Windows.Forms.Button CreateRandomButton;
        private System.Windows.Forms.Button SaveFileButton;
        private System.Windows.Forms.Button OpenFileButton;
        private System.Windows.Forms.Button SearchButton;
    }
}

