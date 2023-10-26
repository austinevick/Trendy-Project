export interface LoginResponseModel {
    status: number;
    message: string;
    data: LoginData;
    token: string;
}

export interface LoginData {
    imageUrl: string;
    _id: string;
    first_name: string;
    last_name: string;
    email: string;
}
