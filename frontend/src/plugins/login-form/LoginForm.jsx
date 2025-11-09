import { useEffect, useState } from "react";
import axios from "axios";
import Cookies from "js-cookie";
import { Button, Form, Input, Tabs, Typography, message } from "antd";

function LoginForm() {
  const [activeTab, setActiveTab] = useState("login");
  const [loginLoading, setLoginLoading] = useState(false);
  const [signupLoading, setSignupLoading] = useState(false);

  useEffect(() => {
    // Prime CSRF token cookie
    axios.get("/api/v1/login/").catch(() => {});
  }, []);

  const getCsrfToken = () => Cookies.get("csrftoken");

  const handleLoginSubmit = async (values) => {
    try {
      setLoginLoading(true);
      const csrfToken = getCsrfToken();
      await axios.post(
        "/api/v1/login/",
        {
          username: values.email.trim().toLowerCase(),
          password: values.password,
        },
        {
          headers: csrfToken
            ? {
                "X-CSRFToken": csrfToken,
              }
            : {},
        }
      );
      message.success("Logged in successfully");
      window.location.href = "/mock_org/tools";
    } catch (error) {
      const errorMessage =
        error?.response?.data?.message ||
        error?.response?.data?.detail ||
        "Unable to login. Please check your credentials.";
      message.error(errorMessage);
    } finally {
      setLoginLoading(false);
    }
  };

  const handleSignupSubmit = async (values) => {
    if (values.password !== values.confirmPassword) {
      message.warning("Passwords do not match");
      return;
    }
    try {
      setSignupLoading(true);
      const csrfToken = getCsrfToken();
      await axios.post(
        "/api/v1/signup/",
        {
          email: values.email.trim().toLowerCase(),
          password: values.password,
          full_name: values.fullName?.trim(),
          organization_name: values.organizationName?.trim(),
          organization_id: values.organizationId?.trim() || undefined,
        },
        {
          headers: csrfToken
            ? {
                "X-CSRFToken": csrfToken,
              }
            : {},
        }
      );
      message.success("Account created successfully");
      window.location.href = "/mock_org/tools";
    } catch (error) {
      const errorMessage =
        error?.response?.data?.message ||
        error?.response?.data?.detail ||
        "Unable to create account. Please try again.";
      message.error(errorMessage);
    } finally {
      setSignupLoading(false);
    }
  };

  const tabs = [
    {
      key: "login",
      label: "Login",
      children: (
        <>
          <Typography.Title level={4}>Sign in to continue</Typography.Title>
          <Form
            layout="vertical"
            onFinish={handleLoginSubmit}
            requiredMark={false}
            autoComplete="off"
          >
            <Form.Item
              label="Email"
              name="email"
              rules={[
                { required: true, message: "Please enter your email" },
                { type: "email", message: "Please enter a valid email" },
              ]}
            >
              <Input placeholder="you@example.com" size="large" />
            </Form.Item>
            <Form.Item
              label="Password"
              name="password"
              rules={[{ required: true, message: "Please enter your password" }]}
            >
              <Input.Password placeholder="Your password" size="large" />
            </Form.Item>
            <Form.Item>
              <Button
                type="primary"
                htmlType="submit"
                size="large"
                block
                loading={loginLoading}
              >
                Login
              </Button>
            </Form.Item>
          </Form>
        </>
      ),
    },
    {
      key: "signup",
      label: "Sign Up",
      children: (
        <>
          <Typography.Title level={4}>
            Create a new workspace
          </Typography.Title>
          <Form
            layout="vertical"
            onFinish={handleSignupSubmit}
            requiredMark={false}
            autoComplete="off"
          >
            <Form.Item
              label="Email"
              name="email"
              rules={[
                { required: true, message: "Please enter your email" },
                { type: "email", message: "Please enter a valid email" },
              ]}
            >
              <Input placeholder="you@example.com" size="large" />
            </Form.Item>
            <Form.Item label="Full name" name="fullName">
              <Input placeholder="Jane Doe" size="large" />
            </Form.Item>
            <Form.Item label="Organization name" name="organizationName">
              <Input placeholder="Acme Corp" size="large" />
            </Form.Item>
            <Form.Item
              label="Organization ID"
              name="organizationId"
              extra="Optional: lowercase letters, numbers, hyphen or underscore."
              rules={[
                {
                  pattern: /^[a-z0-9_-]+$/,
                  message:
                    "Only lowercase letters, numbers, hyphen or underscore are allowed.",
                  validateTrigger: "onSubmit",
                },
              ]}
            >
              <Input placeholder="acme" size="large" />
            </Form.Item>
            <Form.Item
              label="Password"
              name="password"
              rules={[
                { required: true, message: "Please enter a password" },
                {
                  min: 8,
                  message: "Password must be at least 8 characters long",
                },
              ]}
            >
              <Input.Password placeholder="Create a password" size="large" />
            </Form.Item>
            <Form.Item
              label="Confirm password"
              name="confirmPassword"
              dependencies={["password"]}
              rules={[{ required: true, message: "Please confirm your password" }]}
            >
              <Input.Password placeholder="Confirm your password" size="large" />
            </Form.Item>
            <Form.Item>
              <Button
                type="primary"
                htmlType="submit"
                size="large"
                block
                loading={signupLoading}
              >
                Create account
              </Button>
            </Form.Item>
          </Form>
        </>
      ),
    },
  ];

  return (
    <div className="login-form-plugin">
      <Tabs
        centered
        activeKey={activeTab}
        onChange={(key) => setActiveTab(key)}
        items={tabs}
      />
    </div>
  );
}

export { LoginForm };
