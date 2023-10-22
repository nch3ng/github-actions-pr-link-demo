import { CloudFrontRequestEvent } from "aws-lambda";
import cookie from "cookie";

export const handler = async (event: CloudFrontRequestEvent) => {
  const request = event.Records[0].cf.request;
  const host = request.headers.host[0].value;
  const regex = /^pr-([0-9])+.*/g;

  if (regex.test(host)) {
    const subDomain = host.substring(0, host.indexOf("."));

    let prId;

    if (request.headers.cookie) {
      for (let i = 0; i < request.headers.cookie.length; i++) {
        let cookies = cookie.parse(request.headers["cookie"][i].value);
        if (cookies["pr-id"]) {
          prId = cookies["pr-id"];
          break;
        }
      }
    }

    if (!prId) {
      prId = subDomain;
      const response = {
        status: "302",
        statusDescription: "Found",
        body: "setting pr-id cookie",
        headers: {
          "set-cookie": [
            {
              key: "Set-Cookie",
              value: cookie.serialize("pr-id", prId, {
                path: "/"
              })
            }
          ],
          location: [
            {
              key: "Location",
              value: `${request.uri}${
                !!request.querystring ? "?" + request.querystring : ""
              }`
            }
          ]
        }
      };

      console.log(`connect to pr: ${prId}`);
      return response;
    }

    console.log(`connect to pr: ${prId}`);
  }

  return request;
};
