import { ReactNode, createContext, useContext, useMemo } from "react";
import { useLocalStorage } from "../hooks/useLocalStorage";
import { useNavigate } from 'react-router-dom'



interface Props {
    children?: ReactNode
}
interface AuthContextType {
    user: string
}

const AuthContext = createContext({} as AuthContextType);


export const useAuth = () => {
    return useContext(AuthContext);
};

export const AuthProvider = ({ children }: Props) => {

    const [user, setUser] = useLocalStorage('user', null)
    const navigate = useNavigate()

    const login = async (data: string) => {
        setUser(data);
        return navigate('/')
    }

    const logout = () => {
        setUser(null);
        return navigate("/", { replace: true });
    };

    const value = useMemo(() => ({
        user, login, logout
    }), [user]);

    return <AuthContext.Provider value={
        value
    }>{children}</AuthContext.Provider>
}
