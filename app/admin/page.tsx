
import { isAdmin } from "@/lib/admin";
import { redirect } from "next/navigation";
import AdminApp from "./AdminApp";

const AdminPage = async () => {

  if (!isAdmin()) {
    redirect("/");
  }

  return <AdminApp />;
};

export default AdminPage;