import { CloudFrontRequestEvent } from "aws-lambda";

export const handler = async (event: CloudFrontRequestEvent) => {
  const request = event.Records[0].cf.request;
  console.log(JSON.stringify(event.Records[0].cf));
  const headers = request.headers;

  const prId = headers["cookie"]
    ? headers["cookie"][0].value.replace("pr-id=", "")
    : undefined;

  if (prId && request.origin?.s3) {
    request.origin.s3.path = `/${prId}`;
  }

  console.log(`connect to pr: ${prId}`);

  return request;
};
