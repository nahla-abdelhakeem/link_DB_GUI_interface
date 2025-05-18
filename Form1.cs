using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Program_Interface
{
    public partial class Form1 : Form
    {
        static String sql = "Data Source = DESKTOP-UO9GL47 ; Initial Catalog = Supermarket ; Integrated Security= True; User Id='' ; Password=''";
        SqlConnection con = new SqlConnection(sql);
        public Form1()
        {
            InitializeComponent();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {
            dataGridView1.DataSource = LoadUserTable();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                string query = "INSERT INTO employees (e_ID, e_F_Name, employee_sec_ID_FK) VALUES(@e_ID, @e_Name, @employee_sec_ID_FK)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@e_ID", txtID.Text);
                cmd.Parameters.AddWithValue("@e_Name", txtName.Text);
                cmd.Parameters.AddWithValue("@employee_sec_ID_FK", txtSection.Text);
                cmd.ExecuteNonQuery();
                con.Close();

                dataGridView1.DataSource = LoadUserTable();
                MessageBox.Show("Data added successfully.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void button9_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                string query = "UPDATE employees SET e_F_Name = @e_F_Name, employee_sec_ID_FK = @employee_sec_ID_FK WHERE e_ID = @e_ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@e_ID", txtID.Text);
                cmd.Parameters.AddWithValue("@e_F_Name", txtName.Text);
                cmd.Parameters.AddWithValue("@employee_sec_ID_FK", txtSection.Text);
                cmd.ExecuteNonQuery();
                con.Close();

                dataGridView1.DataSource = LoadUserTable();
                MessageBox.Show("Data saved successfully.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
        public DataTable LoadUserTable()
        {
            DataTable dt = new DataTable();
            string query = "SELECT * FROM employees";
            con.Open();
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            con.Close();
            return dt;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                string query = "DELETE FROM employees WHERE e_ID = @e_ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@e_ID", txtID.Text);
                cmd.ExecuteNonQuery();
                con.Close();

                dataGridView1.DataSource = LoadUserTable();
                MessageBox.Show("Data deleted successfully.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                con.Close(); 
                this.Close(); 
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                
                if (dataGridView1.Rows.Count > 0)
                {
                  
                    dataGridView1.CurrentCell = dataGridView1.Rows[0].Cells[0];
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            try
            {
                if (dataGridView1.Rows.Count > 0)
                {
                    int currentRowIndex = dataGridView1.CurrentCell.RowIndex;

        
                    if (currentRowIndex > 0)
                    {
                        dataGridView1.CurrentCell = dataGridView1.Rows[currentRowIndex - 1].Cells[0];
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            try
            {
               
                if (dataGridView1.Rows.Count > 0)
                {
                    int currentRowIndex = dataGridView1.CurrentCell.RowIndex;

                
                    if (currentRowIndex < dataGridView1.Rows.Count - 1)
                    {
                        dataGridView1.CurrentCell = dataGridView1.Rows[currentRowIndex + 1].Cells[0];
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            try
            {
                if (dataGridView1.Rows.Count > 0)
                {
                    string searchID = txtID.Text;
                    bool found = false;

                    foreach (DataGridViewRow row in dataGridView1.Rows)
                    {
                        if (row.Cells["e_ID"].Value != null && row.Cells["e_ID"].Value.ToString() == searchID)
                        {
                            dataGridView1.CurrentCell = row.Cells[0];
                            found = true;
                            break;
                        }
                    }

                    if (!found)
                    {
                        MessageBox.Show("Record not found.");
                    }
                }
                else
                {
                    MessageBox.Show("DataGridView is empty.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
