import PropTypes from "prop-types";
import { createContext, useEffect, useState } from "react";
import io from "socket.io-client";

import { getBaseUrl } from "./GetStaticData";
import { useSessionStore } from "../store/session-store";

const SocketContext = createContext();

const SocketProvider = ({ children }) => {
  const [socket, setSocket] = useState(null);
  const { sessionDetails } = useSessionStore();

  useEffect(() => {
    // Only connect if user is logged in
    if (!sessionDetails?.isLoggedIn) {
      return;
    }

    let baseUrl = "";
    const body = {
      transports: (!process.env.NODE_ENV || process.env.NODE_ENV === "development") 
        ? ["polling"] 
        : ["websocket", "polling"],
      path: "/api/v1/socket",
      autoConnect: false, // Don't auto-connect
    };
    if (!process.env.NODE_ENV || process.env.NODE_ENV === "development") {
      baseUrl = process.env.REACT_APP_BACKEND_URL;
    } else {
      baseUrl = getBaseUrl();
    }
    const newSocket = io(baseUrl, body);
    
    // Connect only after setup
    newSocket.connect();
    setSocket(newSocket);
    
    // Clean up the socket connection on browser unload
    window.onbeforeunload = () => {
      newSocket.disconnect();
    };
    // Clean up the socket connection on component unmount
    return () => {
      newSocket.disconnect();
    };
  }, [sessionDetails?.isLoggedIn]);

  return (
    <SocketContext.Provider value={socket}>{children}</SocketContext.Provider>
  );
};

SocketProvider.propTypes = {
  children: PropTypes.any,
};

export { SocketContext, SocketProvider };
