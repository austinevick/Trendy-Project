const baseUrl = "http://127.0.0.1:3000/api/";
const timeLimit = Duration(seconds: 40);

const Map<String, String> customHeader = {
  'content-type': 'application/json; charset=UTF-8'
};
const noConnection = 'No Internet Connection';
const timeout =
    'Looks like the server is taking to long to respond, You can still try again later.';
const retry =
    "We are unable to load this request at the moment, kindly check your network connection and try again.";
const somethingWentWrong = 'Something went wrong';
const unknownError = 'Unknown Error';
