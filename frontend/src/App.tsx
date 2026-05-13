import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import { ProtectedRoute } from './components/router/ProtectedRoute';
import { AdminRoute } from './components/router/AdminRoute';
import AdminLayout from './components/layout/AdminLayout';
import LoginPage from './pages/LoginPage';
import SearchPage from './pages/SearchPage';
import BecaDetailPage from './pages/BecaDetailPage';
import AdminBecasPage from './pages/admin/AdminBecasPage';
import AdminUsuariosPage from './pages/admin/AdminUsuariosPage';

function App() {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/login" element={<LoginPage />} />
          <Route path="/becas/:id" element={<BecaDetailPage />} />
          <Route
            path="/"
            element={
              <ProtectedRoute>
                <SearchPage />
              </ProtectedRoute>
            }
          />
          <Route
            path="/admin"
            element={
              <AdminRoute>
                <AdminLayout />
              </AdminRoute>
            }
          >
            <Route index element={<AdminBecasPage />} />
            <Route path="becas" element={<AdminBecasPage />} />
            <Route path="usuarios" element={<AdminUsuariosPage />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </AuthProvider>
  );
}

export default App;
