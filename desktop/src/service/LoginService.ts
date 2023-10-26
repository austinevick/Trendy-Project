import { baseUrl } from "../common/api";
import { LoginResponseModel } from "../models/LoginResponseModel";

export const LoginService = async (email: string, password: string) => {
    const response = await fetch(baseUrl + 'user/login', {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            email: email,
            password: password
        })
    });
    const data: LoginResponseModel = await response.json();
    return data;
}
