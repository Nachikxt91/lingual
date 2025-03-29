// app/admin/AdminApp.tsx
"use client";

import dynamic from "next/dynamic";

const App = dynamic(() => import("./app"), { ssr: false });

const AdminApp = () => {
  return <App />;
};

export default AdminApp;