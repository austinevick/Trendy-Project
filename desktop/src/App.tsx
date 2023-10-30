import { Routes, Route } from 'react-router-dom'
import './App.css'
import { Login } from './components/login/Login'
import { Home } from './components/home/Home'
import useToken from './hooks/useToken'
import { NavBar } from './components/navbar/NavBar'


function App() {
  const { token, setToken } = useToken()
  if (!token) {
    return <Login setToken={setToken} />
  }
  return (

    <div className="App">
      <NavBar />
      <Routes>

        <Route path='/' element={<Home />} />
      </Routes>
    </div>
  )
}

export default App
