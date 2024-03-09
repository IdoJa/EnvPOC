namespace EnvPOC
{
    public class EnvironmentSetter
    {
        private static readonly string _env = GetEnvironment();

        private static string GetEnvironment()
        {
            try
            {
                var config = new ConfigurationBuilder()
                    .AddJsonFile("appsettings.json", false)
                    .Build();

                return config.GetSection("Environment").Value;
            }
            catch (Exception)
            {
                return "dev";
            }
        }

        /// <summary>
        /// Creates a configuration root based on the specified environment in
        /// the appsettings.json, mostly used in dotnet 5.
        /// </summary>
        public static IConfigurationRoot CreateConfigurationRoot()
        {
            return new ConfigurationBuilder()
                    .AddJsonFile($"appsettings.{_env}.json", false)
                    .Build();
        }

        /// <summary>
        /// Creates a builder based on the specified environment in the
        /// appsettings.json, mostly used in dotnet 6 and above.
        /// </summary>
        public static WebApplicationBuilder CreateWebApplicationBuilder(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            builder.Configuration.AddJsonFile($"appsettings.{_env}.json");

            return builder;
        }
    }
}
