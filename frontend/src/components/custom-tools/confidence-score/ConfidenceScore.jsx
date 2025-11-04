import { Tooltip, Typography } from "antd";
import { InfoCircleOutlined } from "@ant-design/icons";
import PropTypes from "prop-types";

function ConfidenceScore({ confidenceData, isLoading = false }) {
  // Debug: Always show something
  console.log("ConfidenceScore rendered with:", { confidenceData, isLoading });
  
  if (isLoading) {
    return (
      <Typography.Text className="prompt-cost-item">
        Confidence: <span style={{ color: "#d9d9d9" }}>Loading...</span>
      </Typography.Text>
    );
  }

  if (
    !confidenceData ||
    typeof confidenceData.overall_confidence !== "number"
  ) {
    return (
      <Typography.Text className="prompt-cost-item">
        Confidence:{" "}
        <span style={{ color: "#8c8c8c" }}>
          N/A (Debug: {JSON.stringify(confidenceData)})
        </span>
      </Typography.Text>
    );
  }

  const score = confidenceData.overall_confidence;
  const percentage = Math.round(score * 100);

  // Color coding based on confidence level
  const getColor = (score) => {
    if (score >= 0.7) return "#52c41a"; // Green
    if (score >= 0.4) return "#faad14"; // Orange
    return "#ff4d4f"; // Red
  };

  const getStatus = (score) => {
    if (score >= 0.7) return "High";
    if (score >= 0.4) return "Medium";
    return "Low";
  };

  // Tooltip content with detailed metrics
  const tooltipContent = (
    <div style={{ maxWidth: 300 }}>
      <div style={{ marginBottom: 8 }}>
        <strong>Confidence Score: {percentage}%</strong>
      </div>
      <div style={{ marginBottom: 8 }}>
        Status: <span style={{ color: getColor(score) }}>{getStatus(score)}</span>
      </div>
      {confidenceData.metrics && (
        <div>
          <div style={{ marginBottom: 4 }}>
            <strong>Breakdown:</strong>
          </div>
          {Object.entries(confidenceData.metrics).map(([factor, data]) => {
            return (
              <div key={factor} style={{ fontSize: "12px", marginBottom: 2 }}>
                {factor.replace(/_/g, " ")}: {Math.round(data.score * 100)}%
              </div>
            );
          })}
        </div>
      )}
      {confidenceData.factors && confidenceData.factors.length > 0 && (
        <div style={{ marginTop: 8, fontSize: "11px", color: "#8c8c8c" }}>
          Factors: {confidenceData.factors.join(", ")}
        </div>
      )}
    </div>
  );

  return (
    <Typography.Text className="prompt-cost-item">
      Confidence:{" "}
      <Tooltip title={tooltipContent} placement="top">
        {" "}
        <span
          style={{
            color: getColor(score),
            fontWeight: "bold",
            cursor: "help",
          }}
        >
          {percentage}%
          <InfoCircleOutlined
            style={{
              marginLeft: 4,
              fontSize: "12px",
              opacity: 0.7,
            }}
          />
        </span>
      </Tooltip>
    </Typography.Text>
  );
}

ConfidenceScore.propTypes = {
  confidenceData: PropTypes.shape({
    overall_confidence: PropTypes.number,
    metrics: PropTypes.object,
    factors: PropTypes.array,
  }),
  isLoading: PropTypes.bool,
};

export { ConfidenceScore };
