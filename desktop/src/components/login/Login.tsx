import { Button, IconButton, CircularProgress } from '@mui/material'
import { Visibility, VisibilityOff } from '@mui/icons-material'
import { useState } from 'react'
import './login.css'
import { Props } from '../../hooks/useToken'
import { LoginService } from '../../service/LoginService'

interface TokenProps {
    setToken: (userToken: Props) => void
}

export const Login = ({ setToken }: TokenProps) => {
    const [showPassword, setShowPassword] = useState(false);
    const [IsLoading, setIsLoading] = useState(false);
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')


    const onSubmit = async () => {
        const regexp = new RegExp(/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
        const isEmail = regexp.test(email)

        if (!email || !password) return alert('All fields are required')
        if (!isEmail) return alert('Please enter a valid email')
        try {
            setIsLoading(true)
            const data = await LoginService(email, password)
            if (data.status === 400) {
                alert(data.message)
            } else if (data.status === 200) {
                setToken({
                    token: data.token
                });
            }
            setIsLoading(false)
        } catch (error) {
            console.log(error);
            setIsLoading(false)
        }
    };

    return (
        <div className="login">
            <h3>Welcome back to Trendy</h3>
            <form onSubmit={onSubmit}>
                <div className='email'>
                    <input
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        type="text"
                        placeholder='Enter email' />
                </div>
                <div className="password">
                    <input
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        id='password'
                        type={showPassword ? `text` : `password`}
                        placeholder='Enter password' />
                    <IconButton onClick={() => setShowPassword(!showPassword)}>
                        {showPassword ? <Visibility /> : <VisibilityOff />}
                    </IconButton>
                </div>
                <Button
                    onClick={() => {
                        onSubmit()
                    }}
                    sx={{
                        background: '#0044c0',
                        color: 'white',
                        display: 'flex',
                        width: '25rem',
                        borderRadius: '8px',
                        marginTop: '25px',
                        ":hover": {
                            background: '#1976d2'
                        }
                    }}>
                    {IsLoading ?
                        <CircularProgress sx={{
                            color: 'white'
                        }} />
                        : <div>LOGIN</div>}
                </Button>
            </form>
        </div>
    )
} 