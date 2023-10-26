import { useState } from 'react';

export interface Props {
    token: string
}

export default function useToken() {
    const getToken = () => {
        const tokenString = sessionStorage.getItem('token');
        const userToken = JSON.parse(tokenString as string);
        return userToken?.token
    };

    const [token, setToken] = useState(getToken());


    const saveToken = (userToken: Props) => {
        sessionStorage.setItem('token', JSON.stringify(userToken));
        setToken(userToken.token);
    };

    return {
        setToken: saveToken,
        token
    }
}