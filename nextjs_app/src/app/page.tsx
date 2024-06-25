// src/app/page.tsx
import Layout from "../components/Layout";
import { Container, Box, Typography } from "@mui/material";

const Home = () => {
  return (
    <Layout>
      <Box
        sx={{
          position: "relative",
          minHeight: "100vh",
          backgroundImage: "url('/wall.jpg')",
          backgroundSize: "cover",
          backgroundPosition: "center",
          display: "flex",
          alignItems: "flex-start", // Align items to the top
          justifyContent: "center",
          paddingTop: "2rem", // Push content downward slightly from the top
        }}>
        <Container
          sx={{ position: "relative", zIndex: 1, textAlign: "center" }}>
          <Typography
            variant="h1"
            sx={{
              color: "white",
              fontSize: "8rem", // Large font size
              fontWeight: "bold",
              textShadow: "2px 2px 4px rgba(0, 0, 0, 0.5)",
              marginTop: "0", // Ensure no additional margin at the top
            }}>
            Welcome
          </Typography>
        </Container>
      </Box>
    </Layout>
  );
};

export default Home;
