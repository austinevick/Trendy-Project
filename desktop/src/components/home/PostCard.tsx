import { Comment, Repeat, ThumbUp } from "@mui/icons-material"
import { Button, Card } from "@mui/material"
import './Home.css'
export const PostCard = () => {
    return (
        <Card className="post-card">
            <div className="text">Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit itaque, error mollitia delectus quo id, dolores enim saepe quas nisi rem iusto nulla libero sapiente architecto minus aliquam dolore. Ipsam.</div>
            <div className="image">
                <img src="https://images.pexels.com/photos/18676258/pexels-photo-18676258/free-photo-of-a-red-cable-car-in-the-mountains.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load" alt="" />
            </div>
            <div className="icons">
                <Button>
                    <ThumbUp /><div>Like</div>
                </Button>
                <Button>
                    <Comment /><div>Comment</div>
                </Button>
                <Button >
                    <Repeat /><div>Repost</div>
                </Button>
            </div>


        </Card>
    )
}
