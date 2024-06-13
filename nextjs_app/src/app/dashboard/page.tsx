// src/app/dashboard/page.tsx
import Layout from "../../components/Layout";
import { Container, Typography, Box, Grid } from "@mui/material";

const Dashboard = () => {
  return (
    <Layout>
      <Container>
        <Box sx={{ marginTop: 8 }}>
          <Typography variant="h4" gutterBottom>
            Dashboard
          </Typography>
          <Grid container spacing={4}>
            <Grid item xs={12} sm={6}>
              <Box
                sx={{
                  height: 200,
                  backgroundColor: "green",
                  borderRadius: 4,
                  display: "flex",
                  justifyContent: "center",
                  alignItems: "center",
                }}>
                <Typography variant="h6" color="white">
                  Registered Users
                </Typography>
              </Box>
            </Grid>
            <Grid item xs={12} sm={6}>
              <Box
                sx={{
                  height: 200,
                  backgroundColor: "red",
                  borderRadius: 4,
                  display: "flex",
                  justifyContent: "center",
                  alignItems: "center",
                }}>
                <Typography variant="h6" color="white">
                  Subjects Listed
                </Typography>
              </Box>
            </Grid>
            <Grid item xs={12} sm={6}>
              <Box
                sx={{
                  height: 200,
                  backgroundColor: "yellow",
                  borderRadius: 4,
                  display: "flex",
                  justifyContent: "center",
                  alignItems: "center",
                }}>
                <Typography variant="h6" color="black">
                  Total Classes Listed
                </Typography>
              </Box>
            </Grid>
            <Grid item xs={12} sm={6}>
              <Box
                sx={{
                  height: 200,
                  backgroundColor: "blue",
                  borderRadius: 4,
                  display: "flex",
                  justifyContent: "center",
                  alignItems: "center",
                }}>
                <Typography variant="h6" color="white">
                  Results Declared
                </Typography>
              </Box>
            </Grid>
          </Grid>
        </Box>
      </Container>
    </Layout>
  );
};

export default Dashboard;
