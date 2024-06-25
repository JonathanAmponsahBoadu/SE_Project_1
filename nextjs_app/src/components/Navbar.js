import Link from "next/link";
import { AppBar, Toolbar, Button, Box } from "@mui/material";

const Navbar = () => {
  return (
    <AppBar position="static" sx={{ backgroundColor: "#000000" }}>
      <Toolbar sx={{ display: "flex", justifyContent: "space-between" }}>
        <Box sx={{ display: "flex", alignItems: "center" }}>
          <Link href="/" passHref>
            <Button sx={{ color: "white", textDecoration: "none" }}>
              Home
            </Button>
          </Link>
          <Box sx={{ display: "flex", alignItems: "center", ml: 2 }}>
            <img
              src="/ses.jpg"
              alt="SES"
              style={{
                height: "30px",
                width: "auto",
                marginRight: "32px", // Increased margin to space out the images
              }}
            />
            <img
              src="/ug.png"
              alt="UG"
              style={{
                height: "30px",
                width: "auto",
              }}
            />
          </Box>
        </Box>
        <Box sx={{ display: "flex", alignItems: "center" }}>
          {/* Login link */}
          <Link href="/login" passHref>
            <Button sx={{ color: "white" }}>Login</Button>
          </Link>
          {/* Register link */}
          <Link href="/register" passHref>
            <Button sx={{ color: "white" }}>Register</Button>
          </Link>
          {/* Dashboard link */}
          <Link href="/dashboard" passHref>
            <Button sx={{ color: "white" }}>Dashboard</Button>
          </Link>
        </Box>
      </Toolbar>
    </AppBar>
  );
};

export default Navbar;
