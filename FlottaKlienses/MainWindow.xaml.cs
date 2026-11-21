using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Argon2Sharp;
using System.Net.Http;
using System.Text.Json;
using FlottaKlienses.DTOs;
using System.Net.Http.Json;
using FlottaKlienses.Models;
namespace FlottaKlienses
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        public static HttpClient kliens = new HttpClient()
        {
            BaseAddress = new Uri("https://localhost:7061/")
        };



        public async void bejelentkezes(object sender, RoutedEventArgs e) {
            LoginDTO logindto = new LoginDTO()
            {
                    LoginName=nev.Text,
                    Password=jelszo.Text
            };


            var dtonk = JsonSerializer.Serialize(logindto, JsonSerializerOptions.Default);

            var adottunk = new StringContent(dtonk, Encoding.UTF8, "application/json");

            var eredmeny = await kliens.PostAsync("api/Login",adottunk);

            adott.Text = eredmeny.StatusCode.ToString();
           
        }




        private async void mentes(object sender, RoutedEventArgs e) {
            string url = "api/User/GetAllUser";

            DataGrid.ItemsSource = await kliens.GetFromJsonAsync<List<User>>(url);
        }
    }
}