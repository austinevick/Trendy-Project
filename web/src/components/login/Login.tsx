import { Button, IconButton, CircularProgress } from '@mui/material'
import { useForm } from 'react-hook-form'
import { Visibility, VisibilityOff } from '@mui/icons-material'
import { useState } from 'react'
import { z } from 'zod'
import './login.css'


const loginSchema = z.object({
    email: z.string().email(),
    password: z.string().min(6)
});
type LoginModel = z.infer<typeof loginSchema>;

export const Login = () => {
    const [showPassword, setShowPassword] = useState(false);
    const [IsLoading, setIsLoading] = useState(false);

    return (
        <div className="login">
            <h3>Welcome back to Trendy</h3>
            <form >
                <div className='email'>
                    <input type="text" placeholder='Enter email' />
                </div>
                <div className="password">

                    <input type={showPassword ? `text` : `password`} placeholder='Enter password' />
                    <IconButton onClick={() => setShowPassword(!showPassword)}>
                        {showPassword ? <Visibility /> : <VisibilityOff />}
                    </IconButton>

                </div>
                <Button

                    onClick={() => setIsLoading(!IsLoading)}
                    sx={{
                        background: '#0044c0',
                        color: 'white',
                        display: 'flex',
                        width: '50vw',
                        borderRadius: '8px',
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