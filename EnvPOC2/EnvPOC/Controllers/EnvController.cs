using Microsoft.AspNetCore.Mvc;
using System.Collections;
using System.Text;

namespace EnvPOC.Controllers
{
    [ApiController]
    [Route("api")]
    public class EnvController : ControllerBase
    {
        public AppSettings AppSettings { get; } = AppSettingsSingleton.AppSettings;

        [HttpGet("MyVariable")]
        public string GetMyVariable()
        {
            return AppSettings.MyVariable;
        }
    }
}