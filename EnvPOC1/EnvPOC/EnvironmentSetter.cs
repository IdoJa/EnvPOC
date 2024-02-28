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

        public static WebApplicationBuilder CreateWebApplicationBuilder(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            builder.Configuration.AddJsonFile($"appsettings.{_env}.json");

            return builder;
        }
    }
}
