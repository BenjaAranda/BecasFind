import { BrowserRouter, Routes, Route } from 'react-router-dom';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<div className="min-h-screen bg-gray-50 flex items-center justify-center"><h1 className="text-2xl font-bold text-gray-800">BecasFind</h1></div>} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
