namespace EnvPOC
{
    public sealed class AppSettingsSingleton
    {
        public static AppSettings AppSettings { get; private set; }

        public AppSettingsSingleton(AppSettings appsettings)
        {
            AppSettings ??= appsettings;
        }
    }
}
