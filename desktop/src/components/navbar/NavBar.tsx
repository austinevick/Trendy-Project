import { Link } from "react-router-dom"
import './navbar.css'
import { useState } from "react"
import { HomeOutlined, MessageOutlined, PersonOutline } from "@mui/icons-material"

export const NavBar = () => {
    const [id, setId] = useState<number>()
    return (
        <div className="navbar">
            {/* <div className="avatar"></div>
            <div className="search"></div> */}
            <ul>
                {links.map((link) => (

                    <li key={link.id} onClick={() => setId(link.id)}>
                        <link.icon sx={{
                            color: link.id === id ? 'black' : ''
                        }} />
                        <Link className="link"
                            style={{

                                color: link.id === id ? 'black' : ''
                            }}
                            to={link.path}>{link.name}</Link>

                    </li>
                ))}
            </ul>


        </div>
    )
}

const links = [
    {
        id: 1,
        name: 'Home',
        path: '/',
        icon: HomeOutlined
    },
    {
        id: 2,
        name: 'Messaging',
        path: '/messaging',
        icon: MessageOutlined
    },
    {
        id: 3,
        name: 'Profile',
        path: '/profile',
        icon: PersonOutline
    },
]