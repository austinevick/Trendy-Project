import { Clear, Comment } from "@mui/icons-material"
import { IconButton } from "@mui/material"
import React from "react"

export const Home = () => {
    const [isVisible, setIsVisible] = React.useState(false)

    return (
        <main className="home">
            <div className="video">
                <IconButton onClick={() => setIsVisible(true)}>
                    <Comment />
                </IconButton>
            </div>
            {isVisible && <div className="comments">
                <IconButton onClick={() => setIsVisible(false)}>
                    <Clear />
                </IconButton>
            </div>}
        </main>
    )
}
