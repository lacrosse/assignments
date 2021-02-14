
namespace View
{
    partial class NewComponentForm
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
            this.ComponentTypeBox = new System.Windows.Forms.ComboBox();
            this.programBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.VariableUpDown = new System.Windows.Forms.NumericUpDown();
            this.CreateComponentButton = new System.Windows.Forms.Button();
            this.CancelCreationButton = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.programBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.VariableUpDown)).BeginInit();
            this.SuspendLayout();
            // 
            // ComponentTypeBox
            // 
            this.ComponentTypeBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ComponentTypeBox.FormattingEnabled = true;
            this.ComponentTypeBox.Items.AddRange(new object[] {
            "Resistor",
            "Capacitor",
            "Inductor"});
            this.ComponentTypeBox.Location = new System.Drawing.Point(12, 12);
            this.ComponentTypeBox.Name = "ComponentTypeBox";
            this.ComponentTypeBox.Size = new System.Drawing.Size(212, 21);
            this.ComponentTypeBox.TabIndex = 1;
            // 
            // programBindingSource
            // 
            this.programBindingSource.DataSource = typeof(View.Program);
            // 
            // VariableUpDown
            // 
            this.VariableUpDown.DecimalPlaces = 6;
            this.VariableUpDown.Increment = new decimal(new int[] {
            1,
            0,
            0,
            393216});
            this.VariableUpDown.Location = new System.Drawing.Point(12, 41);
            this.VariableUpDown.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            393216});
            this.VariableUpDown.Name = "VariableUpDown";
            this.VariableUpDown.Size = new System.Drawing.Size(79, 20);
            this.VariableUpDown.TabIndex = 2;
            this.VariableUpDown.Value = new decimal(new int[] {
            2,
            0,
            0,
            0});
            // 
            // CreateComponentButton
            // 
            this.CreateComponentButton.Location = new System.Drawing.Point(97, 39);
            this.CreateComponentButton.Name = "CreateComponentButton";
            this.CreateComponentButton.Size = new System.Drawing.Size(60, 23);
            this.CreateComponentButton.TabIndex = 3;
            this.CreateComponentButton.Text = "OK";
            this.CreateComponentButton.UseVisualStyleBackColor = true;
            this.CreateComponentButton.Click += new System.EventHandler(this.CreateComponentButton_Click);
            // 
            // CancelCreationButton
            // 
            this.CancelCreationButton.Location = new System.Drawing.Point(163, 39);
            this.CancelCreationButton.Name = "CancelCreationButton";
            this.CancelCreationButton.Size = new System.Drawing.Size(61, 23);
            this.CancelCreationButton.TabIndex = 4;
            this.CancelCreationButton.Text = "Cancel";
            this.CancelCreationButton.UseVisualStyleBackColor = true;
            this.CancelCreationButton.Click += new System.EventHandler(this.CancelCreationButton_Click);
            // 
            // NewComponentForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(231, 71);
            this.Controls.Add(this.CancelCreationButton);
            this.Controls.Add(this.CreateComponentButton);
            this.Controls.Add(this.VariableUpDown);
            this.Controls.Add(this.ComponentTypeBox);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "NewComponentForm";
            this.Text = "New component";
            ((System.ComponentModel.ISupportInitialize)(this.programBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.VariableUpDown)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.ComboBox ComponentTypeBox;
        private System.Windows.Forms.NumericUpDown VariableUpDown;
        private System.Windows.Forms.Button CreateComponentButton;
        private System.Windows.Forms.BindingSource programBindingSource;
        private System.Windows.Forms.Button CancelCreationButton;
    }
}