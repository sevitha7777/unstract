import { Typography } from "antd";
import "./Login.css";
import { LoginForm } from "../../plugins/login-form/LoginForm";

function Login() {
  return (
    <div className="login-main">
      <div className="login-card">
        <div className="login-brand">
          <img
            src={`${process.env.PUBLIC_URL || ""}/logo.png`}
            alt="Logo"
            className="login-brand__logo"
          />
        </div>
        <Typography.Text className="login-subtitle">
          Sign in or create an account to access Prompt Studio.
        </Typography.Text>
        <div className="login-card__tabs">
          <LoginForm />
        </div>
      </div>
    </div>
  );
}

export { Login };
