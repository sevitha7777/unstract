import { useEffect } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import { useSessionStore } from "../../store/session-store";
import { GenericLoader } from "../generic-loader/GenericLoader";

function SSOHandler() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const { setSessionDetails } = useSessionStore();

  useEffect(() => {
    const token = searchParams.get("token");
    
    if (!token) {
      navigate("/landing?error=missing_token");
      return;
    }

    // The backend SSO endpoint will handle the JWT validation and login
    // This component just shows a loading state while the redirect happens
    // The actual authentication is handled by the backend SSO view
    
    // If we reach this point, it means the backend SSO succeeded
    // and we should redirect to the main app
    setTimeout(() => {
      navigate("/");
    }, 1000);
    
  }, [searchParams, navigate, setSessionDetails]);

  return (
    <div className="fullscreen-loader">
      <GenericLoader />
      <div style={{ textAlign: "center", marginTop: "20px" }}>
        <p>Authenticating...</p>
      </div>
    </div>
  );
}

export { SSOHandler };