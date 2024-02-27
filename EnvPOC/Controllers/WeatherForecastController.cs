using Microsoft.AspNetCore.Mvc;
using System.Collections;
using System.Text;

namespace EnvPOC.Controllers
{
    [ApiController]
    [Route("api")]
    public class WeatherForecastController : ControllerBase
    {
        [HttpGet("Env")]
        public string GetEnv()
        {
            StringBuilder stringBuilder = new StringBuilder();
            foreach (DictionaryEntry de in Environment.GetEnvironmentVariables())
            {
                stringBuilder.AppendFormat("{0} = {1}\n", de.Key.ToString(), de.Value.ToString());
            }
            return stringBuilder.ToString();
        }

        [HttpGet("isAzureEnv")]
        public bool isAzureEnv()
        {
            foreach (DictionaryEntry de in Environment.GetEnvironmentVariables())
            {
                if (de.Key.ToString().ToUpper().Contains("AZURE")){
                    return true;
                }
            }
            return false;
        }

        [HttpGet("isTestEnv")]
        public bool isTestEnv()
        {
            foreach (DictionaryEntry de in Environment.GetEnvironmentVariables())
            {
                if (de.Key.ToString().ToUpper().Contains("TEST"))
                {
                    return true;
                }
            }
            return false;
        }
    }
}
